if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    # Create a new column lpep_pickup_date by converting lpep_pickup_datetime to a date.
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    # Rename columns in Camel Case to Snake Case, e.g. VendorID to vendor_id.
    data.columns = (data.columns
                    .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                    .str.lower())
    # Remove rows where the passenger count is equal to 0 or the trip distance is equal to zero.
    filtered_df = data[data['passenger_count'] > 0]
    filtered_df2 = filtered_df[filtered_df['trip_distance'] > 0]
    # data[data['passenger_count'] > 0] and data[data['trip_distance'] != 0]
    return filtered_df2


@test
def test_vendor_id(output, *args) -> None:
    assert "vendor_id" in output.head(), 'Snake case transformation not performed'

@test
def test_passenger_count(output, *args) -> None:
    assert (output['passenger_count'] != 0).all(), 'passenger_count transformation not performed'

@test
def test_trip_distance(output, *args) -> None:
    assert (output['trip_distance'] != 0).all(), 'Snake case transformation not performed'