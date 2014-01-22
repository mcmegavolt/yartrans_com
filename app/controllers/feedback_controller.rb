class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create

    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      flash[:success] = t(:'feedback.messages.success')
      FeedbackMailer.delay.feedback(@feedback)
      redirect_to root_path
    else

      @error_msg = ''

      unless @feedback.valid?
        @error_msg += t(:'feedback.messages.bad_form')
      end

      flash[:error] = @error_msg.html_safe
      render :new
    end
  end
end
