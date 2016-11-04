BEGIN{
    line = 0
    hop = 1 
    nextLine = 1
}
{
    line++
    if (line == nextLine)
    {
        printf("%d %g\n", hop, $2)
        nextLine += hop
        hop++
    }
}
END{

}
