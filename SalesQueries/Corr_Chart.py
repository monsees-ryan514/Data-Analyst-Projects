import pandas as pd

df = pd.read_csv(r"C:\Users\Verex\Documents\Data_Analyst\Queries\reviews_weights_distance_daysLate.csv")
df2 = df.corr()
print(df2)

df2.to_csv("C:/Users/Verex/Documents/Data_Analyst/corr_chart.csv")