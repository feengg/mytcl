BEGIN{
    i = 0
}
{
    if ($1 == "avgSendTime:")
        printf("%d %g\n", ++i, $2)
}
END{

}
