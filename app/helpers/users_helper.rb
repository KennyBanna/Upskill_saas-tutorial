module UsersHelper
  def job_title_icon
    if @user.profile.job_title == "Developer"
      "<i class='fa fa-desktop'></i>".html_safe
    elsif @user.profile.job_title == "Investor"
      "<i class='fa fa-dollar'></i>".html_safe
    elsif @user.profile.job_title == "Entrepeneur"
      "<i class='fa fa-briefcase'></i>".html_safe
    end      
  end
end