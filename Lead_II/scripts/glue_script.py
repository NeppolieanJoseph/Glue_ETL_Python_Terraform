"""import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Define source and destination
source_path = "s3://glue-my-source-bucket/data/sample.csv"
destination_path = "s3://glue-my-destination-bucket/data/"

# Read data from source
dynamic_frame = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [source_path]},
    format="csv",
    format_options={"withHeader": True}
)

# Transform data (example transformation)
transformed_dynamic_frame = ApplyMapping.apply(
    frame=dynamic_frame,
    mappings=[("column1", "string", "column1", "string"), ("column2", "string", "column2", "string")]
)

# Write data to destination
glueContext.write_dynamic_frame.from_options(
    frame=transformed_dynamic_frame,
    connection_type="s3",
    connection_options={"path": destination_path},
    format="csv"
)

job.commit()"""


import sys
import boto3
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from pyspark.context import SparkContext

# Initialize GlueContext
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# Read data from S3
datasource = glueContext.create_dynamic_frame.from_catalog(
    database = "my_database",
    table_name = "my_table",
    transformation_ctx = "datasource"
)

# Apply transformations (e.g., filter rows where age > 30)
transformed = datasource.filter(lambda x: x["age"] > 30)

# Write data back to S3
sink = glueContext.write_dynamic_frame.from_options(
    frame = transformed,
    connection_type = "s3",
    connection_options = {"path": "s3://glue-my-destination-bucket/data/"},
    format = "json"
)