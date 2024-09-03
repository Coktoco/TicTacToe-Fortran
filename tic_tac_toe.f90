PROGRAM tic_tac_toe
    IMPLICIT NONE
    CHARACTER(1) :: board(3,3)
    INTEGER :: row, col, turn, choice
    LOGICAL :: game_over, valid_move
    CHARACTER(1) :: player

    CALL menu(choice)
    IF (choice == 1) THEN
        CALL initialize_board(board)
        CALL print_board(board)
        game_over = .FALSE.
        turn = 0

        DO WHILE (.NOT. game_over)
            player = MERGE('X', 'O', MOD(turn, 2) == 0)
            CALL get_move(row, col, board)
            valid_move = .FALSE.
            IF (row >= 1 .AND. row <= 3 .AND. col >= 1 .AND. col <= 3) THEN
                IF (board(row, col) == ' ') THEN
                    board(row, col) = player
                    valid_move = .TRUE.
                ELSE
                    PRINT *, 'To pole jest już zajęte, spróbuj ponownie.'
                END IF
            ELSE
                PRINT *, 'Nieprawidłowe dane, spróbuj ponownie.'
            END IF

            IF (valid_move) THEN
                CALL print_board(board)
                IF (check_winner(board, player)) THEN
                    PRINT *, 'Gracz ', player, ' wygrywa!'
                    game_over = .TRUE.
                    CALL save_result(player)
                ELSE IF (turn == 8) THEN
                    PRINT *, 'Remis!'
                    game_over = .TRUE.
                    CALL save_result(' ')
                ELSE
                    turn = turn + 1
                END IF
            END IF
        END DO
    ELSE IF (choice == 2) THEN
        CALL instructions()
    ELSE
        PRINT *, 'Nieprawidłowy wybór, zamykam program.'
    END IF

CONTAINS

    SUBROUTINE menu(choice)
        INTEGER, INTENT(OUT) :: choice
        INTEGER :: choice_local
        PRINT *, 'Witaj w grze Kółko i Krzyżyk!'
        PRINT *, '1. Nowa gra'
        PRINT *, '2. Instrukcje'
        PRINT *, 'Wybierz opcję (1-2):'
        READ *, choice_local
        choice = choice_local
    END SUBROUTINE menu

    SUBROUTINE initialize_board(b)
        CHARACTER(1), INTENT(OUT) :: b(3,3)
        INTEGER :: i, j
        DO i = 1, 3
            DO j = 1, 3
                b(i, j) = ' '
            END DO
        END DO
    END SUBROUTINE initialize_board

    SUBROUTINE print_board(b)
        CHARACTER(1), INTENT(IN) :: b(3,3)
        INTEGER :: i
        PRINT *, '  1 2 3'
        DO i = 1, 3
            WRITE(*,'(I1,2X,A,1X,A,1X,A)') i, b(i,1), b(i,2), b(i,3)
        END DO
    END SUBROUTINE print_board

    FUNCTION check_winner(b, p) RESULT(win)
        CHARACTER(1), INTENT(IN) :: b(3,3)
        CHARACTER(1), INTENT(IN) :: p
        LOGICAL :: win
        INTEGER :: i
        win = .FALSE.

        DO i = 1, 3
            IF (ALL(b(i,:) == p) .OR. ALL(b(:,i) == p)) THEN
                win = .TRUE.
                RETURN
            END IF
        END DO

        IF (b(1,1) == p .AND. b(2,2) == p .AND. b(3,3) == p) THEN
            win = .TRUE.
        ELSE IF (b(1,3) == p .AND. b(2,2) == p .AND. b(3,1) == p) THEN
            win = .TRUE.
        END IF
    END FUNCTION check_winner

    SUBROUTINE get_move(row, col, b)
        INTEGER, INTENT(OUT) :: row, col
        CHARACTER(1), INTENT(IN) :: b(3,3)
        LOGICAL :: valid
        valid = .FALSE.
        DO WHILE (.NOT. valid)
            PRINT *, 'Podaj rząd i kolumnę (1-3):'
            READ *, row, col
            IF (row >= 1 .AND. row <= 3 .AND. col >= 1 .AND. col <= 3) THEN
                IF (b(row, col) == ' ') THEN
                    valid = .TRUE.
                ELSE
                    PRINT *, 'To pole jest już zajęte, spróbuj ponownie.'
                END IF
            ELSE
                PRINT *, 'Nieprawidłowe dane, spróbuj ponownie.'
            END IF
        END DO
    END SUBROUTINE get_move

    SUBROUTINE save_result(winner)
        CHARACTER(1), INTENT(IN) :: winner
        CHARACTER(LEN=20) :: filename
        INTEGER :: unit, iostat
        filename = 'wyniki_gry.txt'
        OPEN(NEWUNIT=unit, FILE=filename, STATUS='UNKNOWN', ACTION='WRITE', IOSTAT=iostat)
        IF (iostat /= 0) THEN
            PRINT *, 'Nie można otworzyć pliku wyników.'
            RETURN
        END IF
        IF (winner == ' ') THEN
            WRITE(unit, *) 'Gra zakończona remisem.'
        ELSE
            WRITE(unit, *) 'Gracz ', winner, ' wygrał grę.'
        END IF
        CLOSE(unit)
    END SUBROUTINE save_result

    SUBROUTINE instructions()
        PRINT *, 'Instrukcje gry Kółko i Krzyżyk:'
        PRINT *, '1. Gra odbywa się na planszy 3x3.'
        PRINT *, '2. Gracze na przemian stawiają swoje znaki (X lub O).'
        PRINT *, '3. Celem jest ustawienie trzech swoich znaków w linii poziomej, pionowej lub ukośnej.'
        PRINT *, '4. Gracz, który pierwszy ustawi trzy znaki w linii, wygrywa.'
        PRINT *, '5. Jeśli wszystkie pola są wypełnione i żaden z graczy nie ustawi trzech znaków w linii, gra kończy się remisem.'
    END SUBROUTINE instructions

END PROGRAM tic_tac_toe