package main

import (
	"context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	pb "grpc_server/pb"
	"log"
)

func main() {

	conn, err := grpc.Dial("localhost:8000", grpc.WithTransportCredentials(insecure.NewCredentials()))

	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}

	defer conn.Close()

	client := pb.NewStudentsClient(conn)

	newReq := &pb.GetUserRequest{
		Id: 4,
	}

	startResponse, err := client.GetUser(context.Background(), newReq)
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}

	log.Printf("Response : %+v", startResponse)

}
