=begin
def login_as user
    @driver.type 'id=su', user[:name]
    @driver.type "xpath=//input[@value='登陆']", user[:password]
    @driver.click 'name=kw'
    @driver.wait_for_page_to_load
  end
  
def cart_empty?
  @driver.get_text('xpath=...') == 'Shopping Cart(0)'
end
=end

if !("23"=~/^\d+$/)
  puts "match!"
end

def login usr, psd
    dr.find_element(:id => 'u').send_keys(usr)
    dr.find_element(:id => 'p').send_keys(psd)
    dr.find_element(:id => 'login_button').click
end

def login_without_usr_psd
    dr.find_element(:id => 'login_button').click
end

def click_login_btn
    dr.find_element(:id => 'login_button').click
end
 
# now login_without_usr_psd will like below
def login_without_usr_psd
    click_login_btn
end
 
# login function will like this
def login usr, psd
    dr.find_element(:id => 'u').send_keys(usr)
    dr.find_element(:id => 'p').send_keys(psd)
    click_login_btn
end

def login usr, psd
    set_usr usr
    set_psd psd
    click_login_btn
end




=begin
base_page.rb
 
class BrowserContainer
    def initialize driver
        @dr = driver
    end
end # BrowserContainer
 
class Site < BrowserContainer
    def soso_main_page url
        @soso_main_page = SosoMainPage.new(@dr, url)
    end
 
    def close
        @dr.close
    end
end #Site
 
class BasePage < BrowserContainer
    attr_reader :url
 
    def initialize dr, url
        super(dr)
        @url = url  
    end
 
    def open
        @dr.navigate.to @url    
        self
    end
end #BasePage
 
class SosoMainPage < BasePage
    require './login_dialog'
    include LoginDialog
 
    def login usr, psd
        open_login_dialog
        to_dialog_frame
        usr_field.send_keys usr 
        psd_field.send_keys psd
        login_btn.click
    end
 
    def open_login_dialog
        login_link.click
        login_link.send_keys(:enter)
        sleep 2
    end
 
    private
 
    def ua_links
        @dr.find_element(:id => 'ua').find_elements(:css => 'a')
    end
 
    def login_link
        ua_links[3]
    end 
end #SosoMainPage
 
login_dialog.rb     
 
module LoginDialog
    def to_dialog_frame
        begin
            @dr.switch_to.frame('login_frame')  
        rescue
            raise 'Can not switch to login dialog, make sure the dialog was open'
            exit
        end
    end
 
    def usr_field
        @dr.find_element(:id => 'u')
    end
 
    def psd_field
        @dr.find_element(:id => 'p')
    end
 
    def login_btn
        @dr.find_element(:id => 'login_button')
    end
end #LoginDialog
 
login.rb
 
require 'rubygems'
require 'selenium-webdriver'
require './base_page'
 
dr = Selenium::WebDriver.for :firefox
url = 'http://www.soso.com'
soso_page = Site.new(dr).soso_main_page(url).open
soso_page.login 'test', 'test'
=end

=begin
base_page.rb文件中定义了
Site类 主要用于管理测试中所需要用到的各种页面，提供生成这些页面对象的快捷方法。比如Site.new(dr).soso_main_page(url)方法就实例化了1个SosoMainPage对象。
BasePage类 所有Page对象的基类
SosoMainPage类 代表了soso主页的Page Object类，封装了首页的一些测试对象，原子操作及基本步骤，如login

login_dialog.rb文件中定义了代码登陆弹出框的LoginDialog。由于login dialog可能会出现在多个页面，比如qq音乐的登陆页面也有该弹出框，所以将其抽象成module，需要用到的页面直接include该module既可。

login.rb文件调用page object并实现了具体的测试逻辑，这个文件中可以使用你熟悉的测试框架来组织用例，如unit test和rspec等
=end