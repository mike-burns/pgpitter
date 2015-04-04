require 'sig_exception'

class StatusesController < ApplicationController
  def index
    key = Key.find_by_keyid(params[:key_id].sub("0x", ""))
    render text: key.statuses.map(&:source_sig).join("\n")
  end

  def create
    status = Status.new(status_params)
    if status.save
      status.key.populate_signers!
      response.headers['Location'] = hex_url(status.hexid)
      render text: '', status: 201
    else
      render text: status.errors.full_messages.join(', '), status: 400
    end
  rescue SigException => e
    render text: e.message, status: 400
  end

  def show
    status = Status.find_by_hexid(params[:hexid])
    respond_to do |format|
      format.html { @status = status }
      format.json { render json: status }
      format.asc  { render text: status.source_sig }
    end
  end

  private

  def status_params
    params.require(:status).permit(:signed_body, :body, :signature)
  end
end
