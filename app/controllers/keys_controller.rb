class KeysController < ApplicationController
  def show
    @key = Key.find_by_keyid(params[:id].sub("0x", ""))
    @statuses = @key.statuses
  end
end
