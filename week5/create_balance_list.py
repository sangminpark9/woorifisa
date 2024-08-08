import pandas as pd
from openpyxl import Workbook

if __name__ == '__main__':
    # 엑셀 파일 경로
    file_path = './Balance_payment/2024_매출관리.xlsx'
    
    # 엑셀 파일 내 모든 시트를 읽기
    all_sheets_df = pd.read_excel(file_path, sheet_name=None)
    
    # 모든 filtered_df를 저장할 리스트 생성
    all_filtered_dfs = []
    
    # 모든 시트를 처리
    for sheet, data in all_sheets_df.items():
        if sheet == '2023년 미수금':
            continue
        
        data = pd.read_excel(file_path, sheet_name=sheet, header=5, index_col=None)
        
        filtered_df = data[(data['잔액'] != 0) & 
                           (data['일자'] != '합계') & 
                           (data['일자'].notna()) & 
                           (data['잔액'].notna())]
        
        if filtered_df.empty:
            continue
        
        filtered_df['업체명'] = sheet
        
        # 새로운 컬럼을 맨 앞으로 이동
        cols = filtered_df.columns.tolist()
        cols = ['업체명'] + [col for col in cols if col != '업체명']
        filtered_df = filtered_df[cols]
        
        # 필터링된 데이터프레임을 리스트에 추가
        all_filtered_dfs.append(filtered_df)
    
    # 모든 필터링된 데이터프레임을 하나로 합치기
    combined_df = pd.concat(all_filtered_dfs, ignore_index=True)
    
    # 결과를 Excel 파일로 저장
    combined_df.to_excel('./Balance_payment/2024년 매출집계.xlsx', index=False)