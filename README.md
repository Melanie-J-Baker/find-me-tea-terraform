# find-me-tea-terraform

Using Terraform to host (and configure) a fullstack website on Amazon Web Services using Amazon S3, CloudFront, Route53, AWS Certificate Manager, API Gateway, and AWS Lambda.

A simple app called "Find me tea" was created, using the Google Maps Places API to find the nearest places selling tea. This React frontend is hosted on Amazon S3 (also using CloudFront, AWS Certificate and Route53). See the React frontend code here: https://github.com/Melanie-J-Baker/find-me-tea. This frontend makes HTTP requests to a REST API created using API Gateway and AWS Lambda, which in turn makes fetch requests to the Google Places API (Nearby Search) to get locations of nearby places selling tea (within a 2km radius).

This repository contains the Terraform configuration for this AWS hosted project. Terraform modules were used to organise the code. To try out the website visit: https://mel-baker.co.uk

![Image](https://github.com/user-attachments/assets/730110cf-dca4-4ff5-b007-9f62a4933cd9)
![Image](https://github.com/user-attachments/assets/bf3e3e59-e4ce-406b-9abe-4185de6802b5)
