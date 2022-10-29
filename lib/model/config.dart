bool is_local = true;

String base_url = "192.168.3.2/pjsadmin";
String base_url_api = "192.168.3.2/pjsadmin/index.php/Api";

String base_apiendpoint =
    is_local ? "http://$base_url_api" : "https://$base_url_api";
