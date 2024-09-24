import pandas as pd

file_path = r'C:\Users\rabbi\DataAnalysis\Web Page Phishing\Data\web-page-phishing.csv'
data = pd.read_csv(file_path)

data['unique_id'] = data.index + 1

# Table 1: web_page_fishing
web_page_fishing = data[['unique_id', 'url_length', 'n_redirection', 'phishing']]

# Table 2: phishing_dataset
phishing_dataset = data[['unique_id', 'n_dots', 'n_hypens', 'n_underline', 'n_slash', 
                         'n_questionmark', 'n_equal', 'n_at', 'n_and', 'n_exclamation', 
                         'n_space', 'n_tilde', 'n_comma', 'n_plus', 'n_asterisk', 
                         'n_hastag', 'n_dollar', 'n_percent']]

web_page_fishing.to_csv(r'C:\Users\rabbi\DataAnalysis\Web Page Phishing\Data\web_page_fishing.csv', index=False)
phishing_dataset.to_csv(r'C:\Users\rabbi\DataAnalysis\Web Page Phishing\Data\phishing_dataset.csv', index=False)