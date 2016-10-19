BEGIN{
    line = 0
    hop = 14
    nextLine = 1
}
{
    line++
    if (line == nextLine)
    {
        printf("%d %g\n", begin, $2)
        nextLine += hop
        begin += step
    }
}
END{

}
