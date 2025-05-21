import pandas as pd


def calculate_demographic_data(print_data=True):
    # Read data from file
    df = pd.read_csv('adult.data.csv')

    # How many of each race are represented in this dataset? This should be a Pandas series with race names as the index labels.
    race_count = df.race.value_counts()

    # What is the average age of men?
    men= df[df['sex']=='Male']
    average_age_men = men.age.mean().round(1)

    # What is the percentage of people who have a Bachelor's degree?
    educ_series=df.education.value_counts()
    educ_total=educ_series.sum()
    percentage_bachelors = ((educ_series['Bachelors']/educ_total)*100).round(1)

    # What percentage of people with advanced education (`Bachelors`, `Masters`, or `Doctorate`) make more than 50K?
    # What percentage of people without advanced education make more than 50K?

    # with and without `Bachelors`, `Masters`, or `Doctorate`
    higher_education = pd.Series(educ_series, index=['Bachelors','Masters','Doctorate']).sum()
    lower_education = educ_series-higher_education

    # percentage with salary >50K
    edu_rich_series =df[df['salary']=='>50K'].groupby(['education'])['education'].count()
    high_ed_rich_pop = pd.Series(edu_rich_series,index=['Bachelors','Masters','Doctorate']).sum()
    low_ed_rich_pop = edu_rich_series.sum()-high_ed_rich_pop
    higher_education_rich = ((high_ed_rich_pop/higher_education)*100).round(1)
    lower_education_rich = ((low_ed_rich_pop/lower_education)*100).round(1)

    # What is the minimum number of hours a person works per week (hours-per-week feature)?
    min_work_hours = df['hours-per-week'].min()

    # What percentage of the people who work the minimum number of hours per week have a salary of >50K?
    num_min_workers =  df[(df['hours-per-week']<40) & (df['salary']=='>50K')]['salary'].count()
    min_workers = df[df['hours-per-week']<40]['salary'].count()

    rich_percentage = ((num_min_workers/min_workers)*100).round()

    # What country has the highest percentage of people that earn >50K?
    country_series=df.groupby(['native-country'])['native-country'].count()
    country_series=pd.Series(country_series,name='total-workers')
    
    rich_per_country=df[df['salary']=='>50K'].groupby(['native-country'])['native-country'].count()
    rich_per_country=pd.Series(rich_per_country,name='high-income-workers')
   
    percentage_rich = pd.concat([country_series,rich_per_country],axis=1)
    percentage_rich['pct-rich-per-country']=((percentage_rich['high-income-workers']/percentage_rich['total-workers'])*100).round(1)
    
    highest_earning_country = percentage_rich['pct-rich-per-country'].nlargest(1).index[0]
    highest_earning_country_percentage = percentage_rich['pct-rich-per-country'].nlargest(1).iloc[0]


    # Identify the most popular occupation for those who earn >50K in India.
    top_IN_occupation = df[(df['native-country']=='India')&(df['salary']=='>50K')].groupby(['occupation'])['occupation'].count().nlargest(1).index[0]

    # DO NOT MODIFY BELOW THIS LINE

    if print_data:
        print("Number of each race:\n", race_count) 
        print("Average age of men:", average_age_men)
        print(f"Percentage with Bachelors degrees: {percentage_bachelors}%")
        print(f"Percentage with higher education that earn >50K: {higher_education_rich}%")
        print(f"Percentage without higher education that earn >50K: {lower_education_rich}%")
        print(f"Min work time: {min_work_hours} hours/week")
        print(f"Percentage of rich among those who work fewest hours: {rich_percentage}%")
        print("Country with highest percentage of rich:", highest_earning_country)
        print(f"Highest percentage of rich people in country: {highest_earning_country_percentage}%")
        print("Top occupations in India:", top_IN_occupation)

    return {
        'race_count': race_count,
        'average_age_men': average_age_men,
        'percentage_bachelors': percentage_bachelors,
        'higher_education_rich': higher_education_rich,
        'lower_education_rich': lower_education_rich,
        'min_work_hours': min_work_hours,
        'rich_percentage': rich_percentage,
        'highest_earning_country': highest_earning_country,
        'highest_earning_country_percentage':
        highest_earning_country_percentage,
        'top_IN_occupation': top_IN_occupation
    }
