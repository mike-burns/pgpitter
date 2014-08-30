require 'hkp'

class Key < ActiveRecord::Base
  has_many :signatures, foreign_key: :signed_key_id
  has_many :signers, through: :signatures, source: :signing_key, class_name: 'Key'
  has_many :statuses

  def formatted_keyid
    "0x#{keyid}"
  end

  def signers_statuses
    signers.map(&:statuses).flatten
  end

  def populate_signers!
    raw_signers_from_gnupg.each do |raw_signer|
      begin
        populate_signer(raw_signer)
      rescue ActiveRecord::RecordNotUnique
      end
    end
  end

  private

  def populate_signer(raw_signer)
    type, _, _, _, signer_keyid, _, _, _, _, name_and_email, _ = raw_signer.split(":")

    if ["sig", "rev"].include?(type)
      signer_key = Key.find_or_create_by!(keyid: signer_keyid)
      update_signer_key_with_uid_info(name_and_email, signer_key)
      signatures.create!(signing_key: signer_key)
    end
  end

  def update_signer_key_with_uid_info(name_and_email, signer_key)
    if name_and_email != "[User ID not found]"
      name, _email = name_and_email.split(" <")
      email = _email.chomp(">")
      signer_key.update(primary_name: name, primary_email: email)
    end
  end

  def raw_signers_from_gnupg
    `gpg --with-colons --list-sigs #{keyid}`.split("\n")
  end
end
