exports.handler = async (event) => {
    // Lambda function logic here
    const response = {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            message: "Hello from Lambda! (post-google-places-api)"
            // Add more data as needed
        })
    };
    return response;
};