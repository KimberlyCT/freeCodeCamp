import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()

# Import data (Make sure to parse dates. Consider setting index column to 'date'.)
df = pd.read_csv("fcc-forum-pageviews.csv")
df['date']=pd.DatetimeIndex(data=df['date'])
df = df.set_index('date')

# Clean data
df = df[
    (df['value']>= df['value'].quantile(0.025)) &
    (df['value']<= df['value'].quantile(0.975))
]


def draw_line_plot():
    # Draw line plot
    g = sns.lineplot(
        data=df,
        x='date',
        y='value')

    # Add titles and adjust layout
    g.figure.set_size_inches(12,4)
    g.set_title('Daily freeCodeCamp Forum Page Views 5/2016-12/2019')
    g.set_xlabel('Date')
    g.set_ylabel('Page Views')
    g.lines[0].set_color('red')

    # Save image and return fig (don't change this part)
    fig=g.figure
    fig.savefig("line_plot.png")
    return fig

def draw_bar_plot():
    # Copy and modify data for monthly bar plot

    df_bar=df.resample('ME').mean().round()
    df_bar.reset_index(inplace=True)
    df_bar['month'] = [d.strftime('%B') for d in df_bar.date]
    df_bar['year'] = [d.year for d in df_bar.date]
    
    month=['January',
       'February',
       'March',
       'April',
       'May',
       'June',
       'July',
       'August',
       'September',
       'October',
       'November',
       'December']
    
    # Draw bar plot
    h = sns.barplot(
        data=df_bar,
        x='year',
        y='value',
        hue=month,
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
    fig.savefig("bar_plot.png")
    return fig

def draw_box_plot():
    # Prepare data for box plots (this part is done!)
    df_box = df.copy()
    df_box.reset_index(inplace=True)
    df_box['year'] = [d.year for d in df_box.date]
    df_box['month'] = [d.strftime('%b') for d in df_box.date]

    # Draw box plots (using Seaborn)
   

    # Save image and return fig (don't change this part)
    fig.savefig('box_plot.png')
    return fig
