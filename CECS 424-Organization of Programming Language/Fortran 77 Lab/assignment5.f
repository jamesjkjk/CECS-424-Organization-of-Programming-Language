        PROGRAM BINARY
        INTEGER X(9999)

        WRITE(UNIT=*, FMT=*) 'Size of array: '
C       Accept user input for array size
        READ(UNIT=*, FMT=*) N
C       Loop to accept user input for array elements
C       Go to 10 when loop reaches end
        DO 10, I = 1, N
           WRITE(UNIT=*, FMT=*) 'Enter Number', I
           READ(UNIT=*, FMT=*) X(I)
10      CONTINUE
C       Bubble Sort
        DO I = 1, N - 1                       
            DO K = 1, N - 1
                IF ( X(K) .GT. X(K + 1) ) THEN
C                   swap
                    TEMP = X(K)
                    X(K) = X(K + 1)
                    X(K + 1) = TEMP
                END IF
            END DO
        END DO
C       Print array in order       
        DO i = 1, N
            WRITE(UNIT=*, FMT=*) X(i)
        END DO
C       Infinite loop to find elements to search for
        DO WHILE ( .TRUE. )
            WRITE(UNIT=*, FMT=*) 'Enter Number That You Want To Find'
            READ(UNIT=*, FMT=*) NUM
            LOW =  1
            HIGH = N
            MID = (LOW + HIGH) / 2
C           check if num is not mid and low is not high
            DO WHILE( X(MID) .NE. NUM .AND. LOW .NE. HIGH)
C               if number is greater than the mid, ignore left half
                IF (NUM .GT. X(MID))THEN
                    LOW = MID + 1
C               if number is less than the mid, ignore right half                 
                ELSE
                    HIGH = MID - 1
                END IF
                RANGE = HIGH - LOW
                MID = (LOW + HIGH) / 2
            END DO
C           check if numeber exists
                            
            IF( X(MID) .NE. NUM) THEN
                WRITE(UNIT=*, FMT=*) 'Number Does Not Exist'
            ELSE
            WRITE(UNIT=*, FMT=*) 'Number Is At' , MID
            END IF
                    
        END DO
        END
