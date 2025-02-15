# static_pages_controller.rb
# tickets_controller.rb
# dashboard_controller.rb

#        tickets POST   /tickets(.:format)                 tickets#create
#     new_ticket GET    /tickets/new(.:format)             tickets#new
#         ticket GET    /tickets/:id(.:format)             tickets#show
# capture_ticket POST   /tickets/:id/capture(.:format)     tickets#capture
# release_ticket POST   /tickets/:id/release(.:format)     tickets#release
#   close_ticket PATCH  /tickets/:id/close(.:format)       tickets#close
#                DELETE /tickets/:id(.:format)             tickets#destroy

class TicketsController < ApplicationController
  include TicketsHelper

  before_action :authenticate_admin, only: :destroy

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(
      name: params[:ticket][:name],
      phone: format_phone_number(params[:ticket][:phone]),
      description: params[:ticket][:description],
      region_id: params[:ticket][:region_id],
      resource_category_id: params[:ticket][:resource_category_id]
    )
    if @ticket.save
      redirect_to ticket_submitted_path
    else
      render :new
    end
  end

  def show
    return redirect_to dashboard_path unless current_user&.organization&.approved? || current_user&.admin?
    @ticket = Ticket.find(params[:id])
  end

  def capture
    return redirect_to dashboard_path unless current_user&.organization&.approved?

    if TicketService.capture_ticket(params[:id], current_user) == :ok
      redirect_to dashboard_path << '#tickets:open'
    else
      render :show
    end
  end

  def release
    return redirect_to dashboard_path unless current_user&.organization&.approved?

    if TicketService.release_ticket(params[:id], current_user) == :ok
      if current_user.admin?
        redirect_to dashboard_path << '#tickets:captured'
      else
        redirect_to dashboard_path << '#tickets:organization'
      end
    else
      render :show
    end
  end

  def close
    return redirect_to dashboard_path unless current_user&.organization&.approved? || current_user&.admin?

    if TicketService.close_ticket(params[:id], current_user) == :ok
      if current_user.admin?
        redirect_to dashboard_path << '#tickets:open'
      else
        redirect_to dashboard_path << '#tickets:organization'
      end
    else
      render :show
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    redirect_to (dashboard_path << '#tickets'), notice: "Ticket #{ticket.id} was deleted."
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :phone, :description, :region_id, :resource_category_id)
  end

end
