import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress
import numpy as np

def draw_plot():
    # Read data from file
    epa_df=pd.read_csv('epa-sea-level.csv')
    epa_df

    # Create scatter plot
    epa_x=pd.Series(epa_df['Year'])
    epa_y=pd.Series(epa_df['CSIRO Adjusted Sea Level'])
    f = plt.scatter(x=epa_x,y=epa_y,label='Actual Data')
    
    # Create first line of best fit
    slope, intercept, r_value, p_value, std_err = linregress(epa_x, epa_y)
    predx=pd.Series(range(2014,2051,1))
    appendx=pd.concat([epa_x,predx])
    predy=pd.array(slope*appendx+intercept)
    plt.plot(appendx, predy, color='red', label='Regression Line')
    
    # Create second line of best fit
    epa_2k=epa_df[epa_df['Year']>=2000]
    epa_2kx=pd.Series(epa_2k['Year'])
    epa_2ky=pd.Series(epa_2k['CSIRO Adjusted Sea Level'])
    slope_2k, intercept_2k, r_value_2k, p_value_2k, std_err_2k = linregress(epa_2kx, epa_2ky)
    appendx_2k=pd.concat([epa_2kx,predx])
    predy_2k=pd.array(slope_2k*appendx_2k+intercept_2k)
    plt.plot(appendx_2k, predy_2k, color='orange', label='Regression Line 2')

    # Add labels and title
    plt.xticks(np.arange(1850,2076,step=25))
    plt.xlabel('Year')
    plt.ylabel('Sea Level (inches)')
    plt.title('Rise in Sea Level')
    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()