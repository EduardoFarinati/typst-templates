// Homework template for exercises and self-studies
#let project(title: "", author: "", date: none, body) = {
    // Set margins
    let margin = (
        x: 1.00cm,
        y: 3.65cm,
    )

    // Define page counter function
    let page_count = {
        let page_counter = counter(page)

        let page = page_counter.display()
        let total = locate(
            loc => page_counter.final(loc).first()
        )

        [#page / #total]
    }

    // Setup logos
    let logo_height = 0.9cm
    let university_logo = box(height: logo_height)[
        #image("images/encrypted/university_logo.png")
    ]
    let department_logo = box(height: logo_height)[
        #image("images/encrypted/department_logo.svg")
    ]
    let centered_title = box(height: logo_height)[
        #align(horizon)[*#title*]
    ]

    // Set document basic properties
    set document(author: author, title: title)
    set page(
        columns: 1,
        margin: margin,
        header: align(top + center)[
            #v(margin.x) // same margin as horizontal
            #line(length: 100%)
            #h(1fr) #university_logo #h(2fr)
            #centered_title
            #h(2fr) #department_logo #h(1fr)
            #line(length: 100%)
        ],
        header-ascent: 0%,
        footer: align(center + bottom)[
            #line(length: 100%)
            #h(10pt) #author - #date #h(1fr) #page_count #h(10pt)
            #line(length: 100%)
            #v(margin.x) // same margin as horizontal
        ],
        footer-descent: 0%,
    )

    // Set vector style
    set math.vec(delim: "[")
    set math.mat(delim: "[")

    // Set weak pagebreaks, will not pagebreak if
    // a page is left blank
    set pagebreak(weak: true)

    // Save heading and body font families in variables
    let body-family = "Liberation Serif"
    let sans-family = "Liberation Sans"

    // Set body font family.
    set text(font: body-family, lang: "pt")

    // Style headings
    set heading(numbering: none)
    show heading: head => {
        set align(center)
        set text(font: sans-family)
        smallcaps(head.body)
    }

    // Setup enum numbering¨
    set enum(numbering: "1.a.i)")

    // Main body.
    body
}

// Auxiliary functions
#let answer(content) = {
    rect(
        fill: rgb(242, 242, 242), 
        stroke: 0.5pt,
        width: 100%,
        inset: 12pt,
        content
    )
}

#let question(content, answer_content) = {
    box[
        #content
        #answer(answer_content)
        #v(5pt)
    ]
}

