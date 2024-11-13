openapi: 3.0.0
info:
  title: Enterprise API
  version: 1.0.0

paths:
  /putenterprise:
    post:
      summary: "Update Enterprise"
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required:
                - Id
                - name
                - Status
              properties:
                Id:
                  type: string
                name:
                  type: string
                Status:
                  type: boolean
      x-amazon-apigateway-integration:
        uri: "${lambda_uri}"
        httpMethod: POST
        type: aws_proxy

  /getenterprise:
    get:
      summary: "Get Enterprise Information"
      parameters:
        - name: "enterpriseID"
          in: "query"
          required: true
          schema:
            type: string
      x-amazon-apigateway-integration:
        uri: "${lambda_uri}"
        httpMethod: POST
        type: aws_proxy

  /deleteenterprise:
    delete:
      summary: "Delete Enterprise Information"
      parameters:
        - name: "enterpriseID"
          in: "query"
          required: true
          schema:
            type: string
      x-amazon-apigateway-integration:
        uri: "${lambda_uri}"
        httpMethod: POST
        type: aws_proxy