import pandas as pd
import sys

def analysis(ip_fileName,op_fileName):
    #Service Provider Technology Test_type  Data Speed(Mbps)  Signal_strength  LSA
    df = pd.read_csv(ip_fileName)
    #print (df)

    #Dropping the columns of 'Signal_strength' and 'LSA'
    df.drop(['Signal_strength','LSA'],axis=1,inplace=True)
    #print (df)

    #Renaming the column 'Test_type' to 'Test type'
    df.rename(columns = {'Test_type':'Test type'}, inplace = True)
    #print(df)

    #Fetching the rows with Test_type='Download'
    df_filter=df[df["Test type"].str.contains("Download")]
    #print (df_filter)

    df_filter.to_csv(op_fileName,index=False,sep='|')
    
    print ('\nVoila your output is ready int the path: ',op_fileName)
    print ("\n ('_')") 

if __name__ == '__main__':
    if len(sys.argv)==3:
        input_path=sys.argv[1]
        output_path=sys.argv[2]
        analysis(input_path,output_path)
    else:
        print('Arguments are not set')
        print('USAGE -->  myspeed.py input_file_name output_file_name')
        sys.exit()
    