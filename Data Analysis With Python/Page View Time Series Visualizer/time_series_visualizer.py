'''
This code version works for: 
Seaborn: >=0.11.0
Pandas: >=1.1.0

'''

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()
import matplotlib.dates as mdates

# Import data (Make sure to parse dates. Consider setting index column to 'date'.)
df = pd.read_csv("C:/Users/kimct/Documents/freeCodeCamp/Data Analysis With Python/Page View Time Series Visualizer/fcc-forum-pageviews.csv")
df['date']=pd.DatetimeIndex(data=df['date'])
df = df.set_index('date')

# Clean data
df = df[
    (df['value']>= df['value'].quantile(0.025)) &
    (df['value']<= df['value'].quantile(0.975))
]


def draw_line_plot():
    # Draw line plot
    g = sns.lineplot(data=df,
        x=df.index,
        y='value')

    # Add titles and adjust layout
    g.figure.set_size_inches(12,4)
    g.set_title('Daily freeCodeCamp Forum Page Views 5/2016-12/2019')
    g.set_xlabel('Date')
    g.set_ylabel('Page Views')
    g.lines[0].set_color('red')

    # Save image and return fig (don't change this part)
    fig=g.figure
    fig.savefig("C:/Users/kimct/Documents/freeCodeCamp/Data Analysis With Python/Page View Time Series Visualizer/line_plot.png")
    plt.close(fig)
    return fig

def draw_bar_plot():
    
    
    # Copy and modify data for monthly bar plot
    df_bar=df.resample('M').mean().round()
    df_bar.reset_index(inplace=True)
    df_bar['month'] = [d.strftime('%B') for d in df_bar.date]
    df_bar['year'] = [d.year for d in df_bar.date]
    
    month=['January','February','March','April','May','June',
       'July','August','September','October','November','December']
    
    # Draw bar plot
    h = sns.barplot(data=df_bar,
        x='year',
        y='value',
        hue='month',
        hue_order=month,
        palette='bright',
        width=0.5,
        legend=True
        )
    h.figure.set_size_inches(8,8)
    h.set_ylabel('Average Page Views')
    h.set_xlabel('Years')
   
    fig=h.figure

    # Save image and return fig (don't change this part)
    fig.savefig("C:/Users/kimct/Documents/freeCodeCamp/Data Analysis With Python/Page View Time Series Visualizer/bar_plot.png")
    plt.close(fig)
    return fig

def draw_box_plot():

    # Prepare data for box plots (this part is done!)
    df_box = df.copy()
    df_box.reset_index(inplace=True)
    df_box['year'] = [d.year for d in df_box.date]
    df_box['month'] = [d.strftime('%b') for d in df_box.date]

    # Draw box plots (using Seaborn)
    month_short=['Jan','Feb','Mar','Apr','May','Jun',
        'Jul','Aug','Sep','Oct','Nov','Dec']

    boxploti, axbox = plt.subplots(1, 2, figsize=(15, 5))
    sns.boxplot(
        data=df_box,
        x='year',
        y='value',
        palette='deep',
        flierprops={"marker": (4,1,0)},
        ax=axbox[0]  
    )
    axbox[0].set_title('Year-wise Box Plot (Trend)')
    axbox[0].set_xlabel('Year')
    axbox[0].set_ylabel('Page Views')

    color_barmonth=sns.color_palette('husl',12) 
    sns.boxplot(
        data=df_box,
        x='month',
        y='value',
        palette=color_barmonth,
        order=month_short,
        flierprops={"marker": "d"},
        ax=axbox[1]  
    )
    axbox[1].set_title('Month-wise Box Plot (Seasonality)')
    axbox[1].set_xlabel('Month')
    axbox[1].set_ylabel('Page Views')
    
    fig=boxploti.figure

    # Save image and return fig (don't change this part)
    fig.savefig('C:/Users/kimct/Documents/freeCodeCamp/Data Analysis With Python/Page View Time Series Visualizer/box_plot.png')
    plt.close(fig)
    return fig
