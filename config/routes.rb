# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                                 /assets                                                                                           Propshaft::Server
#                                     root GET    /                                                                                                 users#index
#                                    users GET    /users(.:format)                                                                                  users#index
#                                edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
#                                     user GET    /users/:id(.:format)                                                                              users#show
#                         new_user_session GET    /users/sign_in(.:format)                                                                          users/registrations#new
#                             user_session POST   /users/sign_in(.:format)                                                                          users/registrations#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                                         users/registrations#destroy
#                        new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
#                            user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
#                                          PUT    /users/password(.:format)                                                                         devise/passwords#update
#                                          POST   /users/password(.:format)                                                                         devise/passwords#create
#                 cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
#                    new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
#                   edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
#                        user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
#                                          PUT    /users(.:format)                                                                                  devise/registrations#update
#                                          DELETE /users(.:format)                                                                                  devise/registrations#destroy
#                                          POST   /users(.:format)                                                                                  devise/registrations#create
#                             api_v1_users POST   /api/v1/users(.:format)                                                                           api/v1/users#create
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations"  }

  resources :users, path: "admin_users"

  root "pages#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create, :update ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
