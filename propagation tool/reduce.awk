BEGIN{
    distance=100

}
{
    if($3 == "RXThresh_")
    {
        printf("%d: ", distance)
        print $5
        distance += 50
    }
}
END{

}
