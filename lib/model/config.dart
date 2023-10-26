bool is_local = false;

String base_url = is_local ? "localhost/pjadmin" : "admin.pjspaulapp.com";
String base_url_api = "${base_url}/index.php/Api";

String base_apiendpoint =
    is_local ? "http://$base_url_api" : "https://$base_url_api";
