#!/bin/bash

# assuming that $ES has been created and exported before the script is run


# upload eland model
echo "uploading model to ES.."

eland_import_hub_model \
    --url "$ES" \
    --hub-model-id elastic/distilbert-base-uncased-finetuned-conll03-english \
    --task-type ner \
    --insecure \
    --start

# create a pipeline

echo "creating pipeline.."
curl -kX PUT -H "Content-Type: application/json" -d@pipelineparams.json "$ES/_ingest/pipeline/pipeline1"

# upload sample data and process with the pipeline

echo "uploading data.."
curl -sk -H "Content-Type: application/x-ndjson" --data-binary "@import.json" -X POST "$ES/_bulk?pipeline=pipeline1"

# You are ready to query your data!