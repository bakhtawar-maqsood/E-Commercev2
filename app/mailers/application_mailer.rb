# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'bakhtawar.maqsood@devsinc.com'
  layout 'mailer'
end
