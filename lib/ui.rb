class UI
  def out
    STDOUT
  end

  def instream
    STDIN
  end

  def user_input
    instream.gets.chomp
  end

  def prompt message
    out.print message
  end

  def log message
    out.puts message
  end

  def newline
    log ""
  end

  def welcome_message
    log "-------------------------"
    log "- Welcome to TicTacToe! -"
    log "-------------------------"
    log "- Type 'quit' to leave  -"
    log "-------------------------"
  end

  def prompt_for_move
    log ""
    prompt "Pick a square: "
    user_input
  end

  def prompt_for_marker
    prompt "Would you like to be X or O? (O is default) : "
    user_input.upcase
  end

  def player_markers_message opponent, computer
    log "\n\n"
    prompt "You are #{opponent} and the computer will be #{computer}"
    log "\n\n"
  end

  def computer_thinking_message
    log "The computer needs to think a bit"
    3.times { sleep(0.25); prompt "." }
    newline
  end
end

