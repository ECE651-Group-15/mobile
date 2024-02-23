import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> starListing(String customerId, String listingId) async {
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
    'Content-Type': 'application/json'
  };

  var request = http.Request('POST', Uri.parse('http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listing-profile/star-listing'));
  request.body = json.encode({
    "customerId": customerId,
    "listingId": listingId
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseBody);

    if (decodedResponse['code'] == 200) {
      print("Success: ${await response.stream.bytesToString()}");
    } else {
      print("Error: ${response.reasonPhrase ?? 'Unknown Error'}");
    }
  } catch (e) {
    print("Exception occurred: $e");
  }
}
