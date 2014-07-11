[![Codeship Status for yurifrl/delivery_tools](https://www.codeship.io/projects/96de3150-e999-0131-0f9a-5e10f8b94a21/status)](https://www.codeship.io/projects/26209)
delivery tools
==============
delivery-tools.herokuapp.com

##Use example of /
{  
    "tracking_code": "AA123456789BR",
    "shipper_id": 1,
    "url": "http://localhost:3000/api/order_tracker",
    "login_id": "ECT",
    "login_pass": "SRO"
}
##Use example of /zip
{
    "zip": {
        "cep_destino": "90619-900",
        "cep_origem": "04094-050",
        "items": [
            {"altura": 2, "comprimento": 30, "largura": 15, "peso": 0.3 },
            {"altura": 2, "comprimento": 30, "largura": 15, "peso": 0.3 }
        ]
    }
}
##Post to be sent
{
    "tracker_code": "AA123456789BR",
    "status_id": "1",
    "status_name": "delivered"
}