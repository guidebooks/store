# Choose Input Data for RoBERTa

=== "I want to run a quick test with sample data"

    --8<-- "./choose-data-public"
    
=== "I have my own custom input data on S3"
    
    The [CodeFlare](https://codeflare.dev/) [model architecture](https://developer.ibm.com/articles/cc-machine-learning-deep-learning-architectures/) for [RoBERTa](https://huggingface.co/docs/transformers/model_doc/roberta) scales gracefully to
    large datasets. We recommend at least 5GB of raw data.
    
    ```shell
    export CODEFLARE_ROBERTA_DATA=s3
    ```

    :import{s3/choose/object}
