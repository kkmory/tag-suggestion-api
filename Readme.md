# Tag Suggestion API

画像のURLを送りつけると、画像認識を使ってタグをサジェストしてくれるAPIです。

## Usage

Request

``` bash
curl https://endpoint.com/detect-image-label?image-uri={画像のURL}
```

Response

``` json
["風景", "山", "海"]
```

## Setup & Deploy

Ruby 2.7.0 が必要です。  
ローカルでのモックとテストは書いてません（いつか書く）  
ZIPで固めてデプロイもアレなのでやめたい（けどこの規模ならこれでいいや）

``` bash
bundle install --path=vendor/bundle
zip -r handler.zip handler.rb vendor
```

## 使用サービス

画像のタグ付け：[Amazon Rekognition](https://aws.amazon.com/jp/rekognition/)  
タグの翻訳：[Amazon Translate](https://aws.amazon.com/jp/translate/)  
エンドポイント：[Amazon API Gateway](https://aws.amazon.com/jp/api-gateway/), [AWS Lambda](https://aws.amazon.com/jp/lambda/)

## 実行に必要なポリシー

``` bash
AmazonRekognitionReadOnlyAccess
AWSLambdaBasicExecutionRole
TranslateFullAccess
```
