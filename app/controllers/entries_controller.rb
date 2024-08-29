class EntriesController < ApplicationController
  before_action :set_entry, only: [:update]

  def create
    entry = Entry.new(entry_params)
    if entry.save
      trigger_webhooks(entry)
      render json: entry, status: :created
    else
      render json: entry.errors, status: :unprocessable_entity
    end
  end

  def update
    if @entry.update(entry_params)
      trigger_webhooks(@entry)
      render json: @entry, status: :ok
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:name, :data)
  end

  def trigger_webhooks(entry)
    WebhookNotifier.notify(entry)
  end
end
