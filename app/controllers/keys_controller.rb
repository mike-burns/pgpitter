class KeysController < ApplicationController
  def show
    @key = Key.find_by_keyid(params[:id])
    @statuses = @key.statuses
  end
end
