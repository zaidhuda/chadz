# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create!([{ email: 'akuzaid93@yahoo.com'},{ password: '123456' },{ password_confirmation: '123456' }])
@userinfo = UserInfo.find_or_create_by_user_id(@user.id)
@messagebox = Messagebox.find_or_create_by_user_id(@user.id)
@messagebox_attribute = MessageboxAttribute.find_or_create_by_messagebox_id(@messagebox.id)
@color = Color.find_or_create_by_messagebox_attribute_id(@messagebox_attribute.id)
Message.create(:content => 'This is the first message!', :user_id => @user.id, :messagebox_id => @messagebox.id)