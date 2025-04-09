exports.handler = async (event) => {
    console.log("Received event:", event);
    try {
        const response = await fetch('https://places.googleapis.com/v1/places:searchNearby', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': process.env.google_api_key,
            'X-Goog-FieldMask': 'places.displayName,places.location,places.formattedAddress,places.id'
          },
          body: JSON.stringify({
            // Filter results to only include places that serve tea
            includedTypes: ['breakfast_restaurant', 'cafe', 'cat_cafe', 'coffee_shop', 'diner', 'dog_cafe', 'tea_house'],
            maxResultCount: 10,
            locationRestriction: {
              circle: {
                center: {
                  latitude: event.latitude,
                  longitude: event.longitude
                },
                radius: 2000.0 // 2 km
              }
            }
          })
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        return {
            statusCode: 200,
            body: data,
            headers: {
                'Access-Control-Allow-Origin': '*', // or the specific domain
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type,Authorization,X-Api-Key,X-Amz-Security-Token'
            }
        };
    } catch (error) {
        console.error('Fetch error:', error);
        return { error: error.message, status: error.status, body: error.body };
    }
};