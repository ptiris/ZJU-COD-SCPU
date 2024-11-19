#import "@preview/codly:1.0.0": *
#import "@preview/gentle-clues:0.9.0": *
#import "@preview/finite:0.3.0": automaton

#v(1cm)
#align(center, image("./assets/ZJU-Banner.png", width: 50%))

#v(5mm)
#upper(align(center, text(font: "Source Han Serif SC", 2.55em, weight: 600, "本科实验报告")))


#v(20mm)

#v(65mm)

#set text(
  font:"Source Han Serif SC",
  1.3em,
)

#align(
  center,
    box(
      width: 75%,
      table(
        stroke: none, columns: (6.5em + 5pt, 1fr), 
        inset: 0.75em,
        rows: (30pt),

        [课程名称：],[计算机组成与设计],
        table.hline(start: 1),
        [姓 名：],[刘谦],
        table.hline(start: 1),
        [学 号：],[3230106269],
        table.hline(start: 1),
        [学 院：],[计算机科学与技术学院],
        table.hline(start: 1),
        [专 业：],[计算机科学与技术],
        table.hline(start: 1),
        [指导教师：],[刘海风],
        table.hline(start: 1),
        [报告日期：],[2024 年 11 月 19 日],
        table.hline(start: 1)
      )),
    // text(font: "Source Han Serif SC", 1.0em, weight: 600, "姓名: "), "刘谦",
    // text(font: "Source Han Serif SC", 1.0em, weight: 600, "学号: "), "3230106269",
    // text(font: "Source Han Serif SC", 1.0em, weight: 600, "学院: "),"计算机科学与技术学院",
    // text(font: "Source Han Serif SC", 1.0em, weight: 600, "专业: "),"计算机科学",
    // text(font: "Source Han Serif SC", 1.0em, weight: 600, "日期: "), "2024.6.10",

)

#set page(
  paper: "a4",
  header: align(right,text(10pt,weight: 200, font: "New Computer Modern","Computer Orgnization & Design   Lab4"))
)

#show: codly-init.with()

#codly(languages: (
  rust: (name: "Rust", color: rgb("#CE412B")),
  python: (name: "Python", color: rgb("#3572A5")),
  Verilog: (name: "Verilog",color: rgb("#34442A")),
), 
)

#codly(
  zebra-fill: none,
)

#show outline.entry.where(
  level:1,
):it=>{
  v(12pt,weak: true)
  box(strong(it))
}

#show outline.entry.where(
  level: 2
):it=>{
  h(2em)
  it
}

#show outline.entry.where(
  level: 3
):it=>{
  h(3em)
  it
}

#set heading(
  numbering: "1.1.1",
)

#show heading.where(level: 1): it=>[
  #set align(center)
  #set text(15pt,weight: 600, font: ("New Computer Modern","Source Han Serif SC"))
  #block(smallcaps(it.body))
  #v(1em)
]

#show heading.where(level: 2): it=>[
  #set align(left)
  #set text(13pt,weight: 600, font: ("New Computer Modern","Source Han Serif SC"))
  #block(it)
  #v(1em)
]

#show heading.where(level: 3): it=>[
  #set align(left)
  #set text(13pt,weight: 600, font: ("New Computer Modern","Source Han Serif SC"))
  #block(it.body)
]

#set text(
   font: ("New Computer Modern","Source Han Serif SC"),
   size: 11pt
)

#pagebreak()

#outline()

#pagebreak()


