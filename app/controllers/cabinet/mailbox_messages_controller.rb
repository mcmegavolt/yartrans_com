class Cabinet::MailboxMessagesController < Cabinet::DashboardController

  def index
    @box = params[:box] || 'inbox'
    if @box == 'inbox'
      @messages = current_user.mailbox.inbox
    elsif @box == 'sent'
      @messages = current_user.mailbox.sentbox
    elsif @box == 'trash'
      @messages = current_user.mailbox.trash
    end
  end

  def new
    @message = MailboxMessage.new
  end

  def create
    
    @message = MailboxMessage.new params[:mailbox_message]

    if @message.conversation_id
      @conversation = Conversation.find(@message.conversation_id)
      unless @conversation.is_participant?(current_user)
        flash[:alert] = t(:'mailbox.dont_have_permission')
        return redirect_to cabinet_path
      end
      receipt = current_user.reply_to_conversation(@conversation, @message.body, nil, true, true, @message.attachment)
    else
      unless @message.valid?
        return render :new
      end
      receipt = current_user.send_message(@message.recipients, @message.body, @message.subject, true, @message.attachment)
    end
    flash[:notice] = t(:'mailbox.msg_sent')

    redirect_to cabinet_mailbox_message_path(receipt.conversation)
  end

  def show
    @conversation = Conversation.find_by_id(params[:id])
    unless @conversation.is_participant?(current_user)
      flash[:alert] = t(:'mailbox.dont_have_permission')
      return redirect_to cabinet_path
    end
    @message = MailboxMessage.new conversation_id: @conversation.id
    current_user.mark_as_read(@conversation)
  end

  def trash
    conversation = Conversation.find_by_id(params[:id])
    if conversation
      current_user.trash(conversation)
      flash[:notice] = (:'mailbox.msg_sent_to_trash')
    else
      conversations = Conversation.find(params[:conversations])
      conversations.each { |c| current_user.trash(c) }
      flash[:notice] = (:'mailbox.msgs_sent_to_trash')
    end
    redirect_to cabinet_mailbox_messages_path(box: params[:current_box])
  end

  def untrash
    conversation = Conversation.find(params[:id])
    current_user.untrash(conversation)
    flash[:notice] = (:'mailbox.msg_untrashed')
    redirect_to cabinet_mailbox_messages_path(box: 'inbox')
  end

  def search
    @search = params[:search]
    @messages = current_user.search_messages(@search)
    render :index
  end

end