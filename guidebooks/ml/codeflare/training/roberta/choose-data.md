# Choose Input Data for RoBERTa

=== "I want to run a quick test with sample data"
    
    Our sample [WikiText-103](https://developer.ibm.com/exchanges/data/all/wikitext-103/)
    dataset is roughly 1/1000th the
    size of the full IBM Watson-English dataset.
    Resulting models will be overfitted, and should not be
    expected to perform well as general-purpose downstream language
    models.
    
    ```shell
    export CODEFLARE_ROBERTA_DATA=public
    ```
    
=== "I have my own custom input data on S3"
    
    The [CodeFlare](https://codeflare.dev/) [model architecture](https://developer.ibm.com/articles/cc-machine-learning-deep-learning-architectures/) for [RoBERTa](https://huggingface.co/docs/transformers/model_doc/roberta) scales gracefully to
    large datasets. We recommend at least 5GB of raw data.
    
    ```shell
    export CODEFLARE_ROBERTA_DATA=s3
    ```

    :import{s3/choose/object}
