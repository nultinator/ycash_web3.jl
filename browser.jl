import Pkg
function build_deps()
    Pkg.add("HTTP")
    Pkg.add("Gumbo")
    Pkg.add("Cascadia")
    Pkg.add("Blink")
end
using HTTP, Gumbo, Cascadia, Blink
w = Window(async=false)
function goto(address)
    loadurl(w, "$address")
end
function scrape(address)
    r = HTTP.get("$address")
    r_parsed = parsehtml(String(r.body))
    head = r_parsed.root[1]
    body = r_parsed.root[2]
end

function build_yecshell()
    run(`git clone https://github.com/yecdev/yecshell.git`)
    cd("yecshell")
    run(`cargo build --release`)
end
function yecshell(command)
    cd("yecshell/target/release")
    JSON.parse(read(`./zecwallet-cli $command`, String))
end

