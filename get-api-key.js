exports.handler = async (event) => {
    const googleApiKey = process.env.google_api_key;
    const response = {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json"
        },
        body: {
            googleApiKey    
        }
    };
    return response;
};