START

SET YAML
MESSAGES = get from YAML

METHOD valid_loan_amount
  SUBPROCESS

METHOD valid_apr
  SUBPROCESS

METHOD valid_loan_duration_years
  SUBPROCESS

SET INPUT HASH
  loan_amount
  apr
  loan_duration_years

SET OUTPUT HASH
  apr_monthly
  loan_duration_monthly
  monthly_payment


PRINT welcome

LOOP 
  PRINT 'Ask for loan amount'
  GET loan_amount
  IF valid_loan_amount
    SET loan_amount
    BREAK

LOOP 
  PRINT 'Ask for APR'
  GET apr
  IF valid_apr
    SET apr
    SET apr_monthly
    BREAK

LOOP 
  PRINT 'Ask for loan duration'
  GET loan_duration_years
  IF valid_loan_duration_years
    SET loan_duration_years
    SET loan_duration_monthly
    BREAK

monthly_payment = FORMULA

PRINT OUTPUT HASH