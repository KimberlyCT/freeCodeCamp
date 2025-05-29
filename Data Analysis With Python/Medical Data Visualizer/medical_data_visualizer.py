import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# 1
df = pd.read_csv('medical_examination.csv')

# 2
def categorize_bmi(bmi_val):
    if bmi_val > 25:
        return 1
    else:
        return 0
    
df['overweight'] =(df['weight']/(df['height']**2)).apply(categorize_bmi)

# 3
def normalize_cholesterol_glucose(val):
    if val > 1:
        return 1
    else:
        return 0
df['cholesterol'] = df['cholesterol'].apply(normalize_cholesterol_glucose)
df['gluc'] = df['gluc'].apply(normalize_cholesterol_glucose)

# 4
def draw_cat_plot():
    # 5
    df_to_cat = df[["active","alco","cardio","cholesterol","gluc","overweight","smoke"]]
    df_cat =  pd.melt(df_to_cat,id_vars=['cardio'])


    # 6
    df_cat = df_cat.groupby(['cardio','variable','value'],as_index=False).size().rename(columns={'size':'total'})
    

    # 7

    # 8
    fig = sns.catplot(data=df_cat,x='variable',y='total',hue='value',col='cardio',kind='bar',height=5, aspect=1)

    # Add titles and adjust layout
    fig.set_axis_labels("variable", "count")
    fig.set_titles("cardio = {col_name}")
    fig.tight_layout()

    # 9
    g.savefig('catplot.png')
    return g


# 10
def draw_heat_map():
    # 11
    df_heat = df[
        ((df['ap_lo'] <= df['ap_hi']) & 
         (df['height']>=df['height'].quantile(0.025)) & 
         (df['height']<=df['height'].quantile(0.975)) & 
         (df['weight']>=df['weight'].quantile(0.025)) & 
         (df['weight']<=df['weight'].quantile(0.975))) == True]

    # 12
    corr = df_heat.corr()

    # 13
    mask=np.triu(np.ones_like(corr, dtype=bool))


    # 14
    fig, ax = plt.subplots(figsize=(11, 9))

    # 15
    sns.heatmap(corr, mask=mask,center=0,annot=True,fmt=".1f",square=True, linewidths=.5, cbar_kws={"shrink": 0.5})


    # 16
    fig.savefig('heatmap.png')
    return fig
