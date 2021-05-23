import pandas as pd

df1 = pd.read_csv(f'/workspaces/aws_ml/data/timeseries/aggregated_file_pandas.csv_')
df3 = pd.read_csv(f'/workspaces/aws_ml/data/timeseries/aggregated_file_linux.csv_')
assert df3.equals(df1)