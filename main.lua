
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

PADDLE_WIDTH = 10
PADDLE_HEIGHT = 100

BALL_SIZE = 10


PADDLE_SPEED = 200

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.window.setTitle('Pong')

    player1Y = 30
    player2Y = WINDOW_HEIGHT - 30 - PADDLE_HEIGHT

  
    ballX = WINDOW_WIDTH / 2 - BALL_SIZE / 2
    ballY = WINDOW_HEIGHT / 2 - BALL_SIZE / 2
    ballDX = 200
    ballDY = 200

    player1Score = 0
    player2Score = 0
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player1Y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player2Y + PADDLE_SPEED * dt)
    end


    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt

  
    if ballY <= 0 or ballY >= WINDOW_HEIGHT - BALL_SIZE then
        ballDY = -ballDY
    end

    if ballX <= PADDLE_WIDTH and ballY + BALL_SIZE >= player1Y and ballY <= player1Y + PADDLE_HEIGHT then
        ballDX = -ballDX
    elseif ballX >= WINDOW_WIDTH - PADDLE_WIDTH - BALL_SIZE and ballY + BALL_SIZE >= player2Y and ballY <= player2Y + PADDLE_HEIGHT then
        ballDX = -ballDX
    end

    if ballX < 0 then
        player2Score = player2Score + 1
        resetBall()
    elseif ballX > WINDOW_WIDTH then
        player1Score = player1Score + 1
        resetBall()
    end
end

function resetBall()
    ballX = WINDOW_WIDTH / 2 - BALL_SIZE / 2
    ballY = WINDOW_HEIGHT / 2 - BALL_SIZE / 2
    ballDX = -ballDX
    ballDY = ballDY * (love.math.random(2) == 1 and 1 or -1)
end

function love.draw()
    -- Draw paddles
    love.graphics.rectangle('fill', 0, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', WINDOW_WIDTH - PADDLE_WIDTH, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)

    love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE)

    love.graphics.print('Player 1: ' .. player1Score, 10, 10)
    love.graphics.print('Player 2: ' .. player2Score, WINDOW_WIDTH - 100, 10)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
