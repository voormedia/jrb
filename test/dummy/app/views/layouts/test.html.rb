write "<html>".html_safe
write render :partial => "layouts/header"
write "<body>".html_safe + yield + "</body>".html_safe
write "</html>".html_safe
