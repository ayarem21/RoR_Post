ActiveAdmin.register Author do
  #permit_params do
  #  permitted = %i[first_name last_name gender birthday email banned]
  #end
  permit_params :first_name, :last_name, :gender, :birthday, :email, :admin, :banned, :email_confirmed
end
