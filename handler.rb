# frozen_string_literal: true

require 'net/http'
require 'json'
require 'aws-sdk-rekognition'
require 'aws-sdk-translate'
require 'base64'
require 'open-uri'

def request_handler(event:, context:)
  image_uri = event['queryStringParameters']['image-uri']
  resp = detect_label(URI.open(image_uri).read)

  {
    statusCode: 200,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.generate(resp)
  }
end

def detect_label(data)
  client = Aws::Rekognition::Client.new
  attrs = {
    image: {
      bytes: data
    },
    max_labels: 10
  }
  response = client.detect_labels(attrs)
  # Filter
  labels = response.labels.select { |c| c.confidence >= 66 }
  # Translate tag, Generate response array
  labels.map { |l| translate(l[:name].downcase) }
end

def translate(target)
  client = Aws::Translate::Client.new
  resp = client.translate_text(
    text: target,
    source_language_code: 'en',
    target_language_code: 'ja'
  )
  resp.translated_text
end
