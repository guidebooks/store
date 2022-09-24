# Choose Input Data for RoBERTa

=== "I want to run a quick test with sample data"
    --8<-- "./choose-data-public"
    
=== "I have my own input tar.gz file on S3"
    
    If your input shards are stored in a tar.gz file in S3, select this option. [CodeFlare](https://codeflare.dev/)'s [model architecture](https://developer.ibm.com/articles/cc-machine-learning-deep-learning-architectures/) for [RoBERTa](https://huggingface.co/docs/transformers/model_doc/roberta) scales gracefully to
    large datasets. We recommend at least 5GB of raw data.
    
    ```shell
    export ML_CODEFLARE_ROBERTA_DATA=s3
    ```

    :import{s3/choose/object}

=== "My S3 data will be pre-mounted via s3fs"
    :import{./choose-data-s3fs}
