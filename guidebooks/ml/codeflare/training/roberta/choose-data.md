# Choose Input Data for RoBERTa

The RoBERTa pre-training code assumes its input data is accessible as
a mounted filesystem. You can set this up in one of three ways.

=== "I want to run a quick test with sample data"

    --8<-- "./choose-data-public"
    
=== "I have my own input tar.gz file on S3"
    
    If your input shards are stored in a tar.gz file in S3, select this option. [CodeFlare](https://codeflare.dev/)'s [model architecture](https://developer.ibm.com/articles/cc-machine-learning-deep-learning-architectures/) for [RoBERTa](https://huggingface.co/docs/transformers/model_doc/roberta) scales gracefully to
    large datasets. We recommend at least 5GB of raw data.
    
    ```shell
    export S3_DATA=s3
    ```

    :import{s3/choose/object}

=== "I will use data premounted from S3FS"
    To run with the full or a custom data set, choose this option.
    
    :import{s3/choose/bucket}
    :import{s3/choose/s3fs/kubernetes}
