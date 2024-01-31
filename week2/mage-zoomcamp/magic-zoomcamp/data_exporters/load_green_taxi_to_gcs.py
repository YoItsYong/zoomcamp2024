import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/civil-charmer-410021-abcbedc04c1c.json'

bucket_name='dtc-week2-hw'
project_id='civil-charmer-410021'
table_name='green_taxi'
schema_name = 'mage'

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):
    table = pa.Table.from_pandas(data)
    gcs = pa.fs.GcsFileSystem()
    pq.write_to_dataset(
        table,
        root_path=root_path,
        existing_data_behavior='overwrite_or_ignore',
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )
    